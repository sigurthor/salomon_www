desc "This task is called by the Heroku scheduler add-on"

task :update_vimoe_feed => :environment do
  puts "Updating vimo feed..."
  im = A2::VimeoImport.new
  im.import

  puts "vimeo end"
end

task :update_instagram_feed => :environment do
  puts "Updating vimo feed..."
  im = A2::InstagramImport.new
  im.import

  puts "instagram end"
end


task :update_facebook_feed => :environment do
  puts "Updating vimo feed..."
  im = A2::FacebookImport.new
  im.import

  puts "facebook end"
end