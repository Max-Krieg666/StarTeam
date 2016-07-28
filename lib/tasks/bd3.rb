#Страны
require 'httparty'
@countries = HTTParty.get 'http://api.vk.com/method/database.getCountries?v=5.21&need_all=1&count=500'
@c1 = []
@countries['response']['items'].each do |attrs|
  @c1 << attrs['title']
end
@pos = %w(Gk Ld Cd Rd Lm Cm Rm Lf Cf Rf)
@pos << 'Cm'
@pos << 'Cd'
@pos << 'Cm'
@pos << 'Cf'