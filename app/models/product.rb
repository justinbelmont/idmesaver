class Product < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  attr_accessor :response, :parsed_response, :item, :price, :image, :discount, :converse_w_saved, :converse_w_retail_price, :converse_w_product_image, :converse_w_product_title, :converse_w_student_price, :theory_m_retail_price, :theory_m_product_image, :theory_m_product_title, :theory_m_student_price, :theory_m_saved, :theory_w_retail_price, :theory_w_product_image, :theory_w_product_title, :theory_w_student_price, :theory_w_saved

require 'rest_client'

CONVERSE_DISCOUNT = 0.20
THEORY_DISCOUNT = 0.20
JCREW_DISCOUNT = 0.15
FAHERTY_DISCOUNT = 0.20

def initialize

# GET ALL THE DATA 
  conversemen = RestClient.get 'http://www.kimonolabs.com/api/6wl3jrra?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  conversewomen = RestClient.get 'http://www.kimonolabs.com/api/d5zydwiu?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  
  theorywomen = RestClient.get 'http://www.kimonolabs.com/api/c7ui87gw?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  theorymen = RestClient.get 'http://www.kimonolabs.com/api/4kwjdn8g?apikey=85bcefb6f51d73a5223de8528c4fb2dc'

  jcrewwomen = RestClient.get 'http://www.kimonolabs.com/api/4qjzgxmk?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  jcrewmen = RestClient.get 'http://www.kimonolabs.com/api/3hznva6u?apikey=85bcefb6f51d73a5223de8528c4fb2dc'

  fahertywomen = RestClient.get 'http://www.kimonolabs.com/api/4nj9de08?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  fahertymen = RestClient.get 'http://www.kimonolabs.com/api/8be070ku?apikey=85bcefb6f51d73a5223de8528c4fb2dc'

  conversecover = RestClient.get 'http://www.kimonolabs.com/api/8hgsxo4a?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  jcrewcover = RestClient.get 'http://www.kimonolabs.com/api/dkn0vru6?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  fahertycover = RestClient.get 'http://www.kimonolabs.com/api/3e4rgjes?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  theorycover = RestClient.get 'http://www.kimonolabs.com/api/a490m1x6?apikey=85bcefb6f51d73a5223de8528c4fb2dc'

  uacover = RestClient.get 'https://www.kimonolabs.com/api/bglsnu9m?apikey=85bcefb6f51d73a5223de8528c4fb2dc'

  columbiacover = RestClient.get 'https://www.kimonolabs.com/api/70g9dqd6?apikey=85bcefb6f51d73a5223de8528c4fb2dc'

  dellcover = RestClient.get 'https://www.kimonolabs.com/api/dzwg9phi?apikey=85bcefb6f51d73a5223de8528c4fb2dc'

#PARSE AND FORMAT ALL THE DATA
#CONVERSE
  @parsed_conversemen = JSON.parse(conversemen)
  @data = @parsed_conversemen["results"]["collection1"]

  @parsed_conversewomen = JSON.parse(conversewomen)
  @dataw = @parsed_conversewomen["results"]["collection1"]


# COVER IMAGES
  @parsed_conversecover = JSON.parse(conversecover)
  @conversec = @parsed_conversecover["results"]["collection1"]

  @parsed_jcrewcover = JSON.parse(jcrewcover)
  @jcrewc = @parsed_jcrewcover["results"]["collection1"]

  @parsed_fahertycover = JSON.parse(fahertycover)
  @fahertyc = @parsed_fahertycover["results"]["collection1"]

  @parsed_theorycover = JSON.parse(theorycover)
  @theoryc = @parsed_theorycover["results"]["collection1"]

  @parsed_uacover = JSON.parse(uacover)
  @uac = @parsed_uacover["results"]["collection1"]

  @parsed_columbiacover = JSON.parse(columbiacover)
  @columbiac = @parsed_columbiacover["results"]["collection1"]

  @parsed_dellcover = JSON.parse(dellcover)
  @dellc = @parsed_dellcover["results"]["collection1"]

#THEORY
  @parsed_theory_w = JSON.parse(theorywomen)
  @theory_w = @parsed_theory_w["results"]["collection1"]

  @parsed_theory_m = JSON.parse(theorymen)
  @theory_m = @parsed_theory_m["results"]["collection1"]  

#JCREW
  @parsed_jcrew_w = JSON.parse(jcrewwomen)
  @jcrew_w = @parsed_jcrew_w["results"]

  @parsed_jcrew_m = JSON.parse(jcrewmen)
  @jcrew_m = @parsed_jcrew_m["results"] 

#FAHERTY

  @parsed_faherty_w = JSON.parse(fahertywomen)
  @faherty_w = @parsed_faherty_w["results"]["collection1"]

  @parsed_faherty_m = JSON.parse(fahertymen)
  @faherty_m = @parsed_faherty_m["results"]["collection1"]

end

# MENS CONVERSE

def retail_price(item)
  retail_price = @data[item]["mens-shoes-prices"].gsub(/[^\d\.]/, '').to_i
  number_to_currency(retail_price.to_i, :precision => 0)
end

def product_image(item)
  @data[item]["mens-shoes-imgs"]["src"]
end

def product_title(item)
  @data[item]["mens-shoes-imgs"]["alt"].truncate(30)
end

def student_price(item)
  retail_price = @data[item]["mens-shoes-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - CONVERSE_DISCOUNT)
  number_to_currency(student_price.to_i, :precision => 0)
end

def saved(item)
  retail_price = @data[item]["mens-shoes-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - CONVERSE_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i, :precision => 0)
end


# WOMENS CONVERSE

def converse_w_retail_price(item)
  retail_price = @dataw[item]["sneakers-prices"].gsub(/[^\d\.]/, '').to_i
  number_to_currency(retail_price.to_i, :precision => 0)
end

def converse_w_product_image(item)
  @dataw[0]["sneaker-imgs"]["src"]
end

def converse_w_product_title(item)
  @dataw[item]["sneakers-title"]["text"].truncate(30)
end

def converse_w_student_price(item)
  retail_price = @dataw[item]["sneakers-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - CONVERSE_DISCOUNT)
  number_to_currency(student_price.to_i, :precision => 0)
end

def converse_w_saved(item)
  retail_price = @dataw[item]["sneakers-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - CONVERSE_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i, :precision => 0)
end

# MEN'S THEORY

def theory_m_retail_price(item)
  retail_price = @theory_m[item]["theory-men-price"].gsub(/[^\d\.]/, '').to_i
  number_to_currency(retail_price.to_i, :precision => 0)
end

def theory_m_product_image(item)
  @theory_m[item]["theory-men-imgs"]["src"]
end

def theory_m_product_title(item)
  @theory_m[item]["theory-men-title"]["text"].truncate(45)
end

def theory_m_student_price(item)
  retail_price = @theory_m[item]["theory-men-price"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - THEORY_DISCOUNT)
  number_to_currency(student_price.to_i, :precision => 0)
end

def theory_m_saved(item)
  retail_price = @theory_m[item]["theory-men-price"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - THEORY_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i, :precision => 0)
end


# WOMEN'S THEORY


def theory_w_retail_price(item)
  retail_price = @theory_w[item]["theory-women-prices"].gsub(/[^\d\.]/, '').to_i
  number_to_currency(retail_price.to_i, :precision => 0)
end

def theory_w_product_image(item)
  @theory_w[item]["theory-women-imgs"]["src"]
end

def theory_w_product_title(item)
  @theory_w[item]["theory-women-titles"]["text"].truncate(45)
end

def theory_w_student_price(item)
  retail_price = @theory_w[item]["theory-women-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - THEORY_DISCOUNT)
  number_to_currency(student_price.to_i, :precision => 0)
end

def theory_w_saved(item)
  retail_price = @theory_w[item]["theory-women-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - THEORY_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i, :precision => 0)
end

# MENS JCREW - ELIMATED FROM VIEW AS JCREW JSON IS RETURNING NIL

def jcrew_m_retail_price(item)
  retail_price = @jcrew_m["collection2"][item]["jcrew-mens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  number_to_currency(retail_price.to_i, :precision => 0)
end

def jcrew_m_product_image(item)
  @jcrew_m["collection1"][item]["jcrew-mens-imgs"]["src"]
end

def jcrew_m_product_title(item)
  @jcrew_m["collection2"][item]["jcrew-mens-titles"]["text"].truncate(30)
end

def jcrew_m_student_price(item)
  retail_price = @jcrew_m["collection2"][item]["jcrew-mens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - JCREW_DISCOUNT)
  number_to_currency(student_price.to_i, :precision => 0)
end

def jcrew_m_saved(item)
  retail_price = @jcrew_m["collection2"][item]["jcrew-mens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - JCREW_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i, :precision => 0)
end

# WOMENS JCREW - ELIMATED FROM VIEW AS JCREW JSON IS RETURNING NIL

def jcrew_w_retail_price(item)
  retail_price = @jcrew_w["collection1"][item]["jcrew-womens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  number_to_currency(retail_price.to_i, :precision => 0)
end

def jcrew_w_product_image(item)
  @jcrew_w["collection1"][item]["jcrew-womens-imgs"]["src"]
end

def jcrew_w_product_title(item)
  @jcrew_w["collection2"][item]["jcrew-womens-titles"]["text"].truncate(30)
end

def jcrew_w_student_price(item)
  retail_price = @jcrew_w["collection2"][item]["jcrew-womens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - JCREW_DISCOUNT)
  number_to_currency(student_price.to_i, :precision => 0)
end

def jcrew_w_saved(item)
  retail_price = @jcrew_w["collection2"][item]["jcrew-womens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - JCREW_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i, :precision => 0)
end

# WOMEN'S FAHERTY

def faherty_w_retail_price(item)
  retail_price = @faherty_w[item]["faherty-womens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  number_to_currency(retail_price.to_i, :precision => 0)
end

def faherty_w_product_image(item)
  @faherty_w[item]["faherty-womens-imgs"]["src"]
end

def faherty_w_product_title(item)
  @faherty_w[item]["faherty-womens-titles"]["text"].truncate(35)
end

def faherty_w_student_price(item)
  retail_price = @faherty_w[item]["faherty-womens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - FAHERTY_DISCOUNT)
  number_to_currency(student_price.to_i, :precision => 0)
end

def faherty_w_saved(item)
  retail_price = @faherty_w[item]["faherty-womens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - FAHERTY_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i, :precision => 0)
end

# MEN'S FAHERTY

def faherty_m_retail_price(item)
  retail_price = @faherty_m[item]["faherty-mens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  number_to_currency(retail_price.to_i, :precision => 0)
end

def faherty_m_product_image(item)
  @faherty_m[item]["faherty-mens-imgs"]["src"]
end

def faherty_m_product_title(item)
  @faherty_m[item]["faherty-mens-titles"]["text"].truncate(35)
end

def faherty_m_student_price(item)
  retail_price = @faherty_m[item]["faherty-mens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - FAHERTY_DISCOUNT)
  number_to_currency(student_price.to_i, :precision => 0)
end

def faherty_m_saved(item)
  retail_price = @faherty_m[item]["faherty-mens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - FAHERTY_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i, :precision => 0)
end

# COVER PICTURES

def conversec_image(item)
  @conversec[item]["conversecover"]["src"]
end

def jcrewc_image(item)
  @jcrewc[item]["jcrew-cover"]["src"]
end

def fahertyc_image(item)
  @fahertyc[item]["faherty_cover"]["src"]
end

def theoryc_image(item)
  @theoryc[item]["theory_cover"]["src"]
end

def uac_image(item)
  @uac[item]["ua-cover"]["src"]
end

def columbiac_image(item)
  @columbiac[item]["columbia-cover"]["src"]
end

def dellc_image(item)
  @dellc[item]["dell-cover"]["src"]
end

end
