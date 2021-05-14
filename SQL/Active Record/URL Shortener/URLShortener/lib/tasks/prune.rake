namespace :prune do
    desc "prunes old links from the shortened_urls table"
    task prune_links: :environment do
        puts "Pruning old links..."
        ShortenedUrl.prune(10)
    end
end