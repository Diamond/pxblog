# Pxblog

To start your Phoenix app:
  
  1. Change into the directory you want your project installed in with `cd example-folder`
  2. SSH clone this repo with `git clone git@github.com:Diamond/pxblog.git`
  3. Change into the pxblog directory with `cd pxblog`
  4. Install dependencies with `mix deps.get`
  5. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  6. Populate the database with a user that has admin privileges with `mix run priv/rep/seeds.exs`
  7. Install your npm dependencies with `npm install`
  6. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser and login with `admin` `test`. You can see your posts by visiting [`http://localhost:4000/users/1/posts`](http://localhost:4000/users/1/posts).

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
