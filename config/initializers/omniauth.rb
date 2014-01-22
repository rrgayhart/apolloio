OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :twitter, 'uxNjavxD0wg6j4pCsIww', '3PGCE2T6YkKJRUjt56vNUzxJB7bWdNdx1b5znIpOeY'
end
