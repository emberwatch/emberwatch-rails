class CreatePodcastFeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :podcast_feeds do |t|
      t.string :url

      t.timestamps
    end
  end
end
