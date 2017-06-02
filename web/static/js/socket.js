// Import the socket library
import { Socket } from 'phoenix';
// And import jquery for DOM manipulation
import $ from 'jquery';

// Grab the user's token from the meta tag
const userToken = $("meta[name='channel_token']").attr('content');
// And make sure we're connecting with the user's token to persist the user id to the session
const socket = new Socket('/socket', { params: { token: userToken } });
// And connect out
socket.connect();

// Our actions to listen for
const CREATED_COMMENT = 'CREATED_COMMENT';
const APPROVED_COMMENT = 'APPROVED_COMMENT';
const DELETED_COMMENT = 'DELETED_COMMENT';

// REQ 1: Grab the current post's id from a hidden input on the page
const postId = $('#post-id').val();
const channel = socket.channel(`comments:${postId}`, {});
channel
  .join()
  .receive('ok', resp => {
    console.log('Joined successfully', resp);
  })
  .receive('error', resp => {
    console.log('Unable to join', resp);
  });

// REQ 2: Based on a payload, return to us an HTML template for a comment
// Consider this a poor version of JSX
const createComment = payload => `
  <div id="comment-${payload.commentId}" class="comment" data-comment-id="${payload.commentId}">
    <div class="row">
      <div class="small-4 columns">
        <strong class="comment-author">${payload.author}</strong>
      </div>
      <div class="small-4 columns">
        <em>${payload.insertedAt}</em>
      </div>
      <div class="small-4 columns text-right">
        ${userToken ? '<button class="button tiny primary approve">Approve</button> <button class="button tiny alert delete">Delete</button>' : ''}
      </div>
    </div>
    <div class="row">
      <div class="small-12 columns comment-body">
        ${payload.body}
      </div>
    </div>
  </div>
`;
// REQ 3: Provide the comment's author from the form
const getCommentAuthor = () => $('#comment_author').val();
// REQ 4: Provide the comment's body from the form
const getCommentBody = () => $('#comment_body').val();
// REQ 5: Based on something being clicked, find the parent comment id
const getTargetCommentId = target => $(target).parents('.comment').data('comment-id');
// REQ 6: Reset the input fields to blank
const resetFields = () => {
  $('#comment_author').val('');
  $('#comment_body').val('');
};

// REQ 7: Push the CREATED_COMMENT event to the socket with the appropriate author/body
$('.create-comment').on('click', event => {
  event.preventDefault();
  channel.push(CREATED_COMMENT, { author: getCommentAuthor(), body: getCommentBody(), postId });
  resetFields();
});

// REQ 8: Push the APPROVED_COMMENT event to the socket with the appropriate author/body/comment id
$('.comments').on('click', '.approve', event => {
  event.preventDefault();
  const commentId = getTargetCommentId(event.currentTarget);
  // Pull the approved comment author
  const author = $(`#comment-${commentId} .comment-author`).text().trim();
  // Pull the approved comment body
  const body = $(`#comment-${commentId} .comment-body`).text().trim();
  channel.push(APPROVED_COMMENT, { author, body, commentId, postId });
});

// REQ 9: Push the DELETED_COMMENT event to the socket but only pass the comment id (that's all we need)
$('.comments').on('click', '.delete', event => {
  event.preventDefault();
  const commentId = getTargetCommentId(event.currentTarget);
  channel.push(DELETED_COMMENT, { commentId, postId });
});

// REQ 10: Handle receiving the CREATED_COMMENT event
channel.on(CREATED_COMMENT, payload => {
  // Don't append the comment if it hasn't been approved
  if (!userToken && !payload.approved) {
    return;
  }
  // Add it to the DOM using our handy template function
  $('.comments h2').after(createComment(payload));
});

// REQ 11: Handle receiving the APPROVED_COMMENT event
channel.on(APPROVED_COMMENT, payload => {
  // If we don't already have the right comment, then add it to the DOM
  if ($(`#comment-${payload.commentId}`).length === 0) {
    $('.comments h2').after(createComment(payload));
  }
  // And then remove the "Approve" button since we know it has been approved
  $(`#comment-${payload.commentId} .approve`).remove();
});

// REQ 12: Handle receiving the DELETED_COMMENT event
channel.on(DELETED_COMMENT, payload => {
  // Just delete the comment from the DOM
  $(`#comment-${payload.commentId}`).remove();
});

export default socket;
