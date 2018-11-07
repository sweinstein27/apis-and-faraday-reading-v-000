class SearchesController < ApplicationController

  def foursquare
   @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
     req.params['client_id'] = 'FD2BMMLA53ZFXUQ3GR1MPZHOY23NXVGF1IJXOPU2QYD0CZND'
     req.params['client_secret'] = 'FMPILX2IBYDE0W1XIL42UNIJQTZ5COJUWFXTMCEE4DTQIIGE'
     req.params['v'] = '20160201'
     req.params['near'] = params[:zipcode]
     req.params['query'] = 'coffee shop'
   end
  body = JSON.parse(@resp.body)
  if @resp.success?
    @venues = body["response"]["venues"]
  else
    @error = body["meta"]["errorDetail"]
  end

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end
  render 'search'
 end
end
