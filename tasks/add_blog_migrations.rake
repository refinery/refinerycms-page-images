# HACKS: Add the refinerycms-blog migrations to dummy_app and re-migrate.
task "refinery:testing:dummy_app" do
  system("bundle exec rake refinery_blog:install:migrations db:migrate db:test:prepare")
end
