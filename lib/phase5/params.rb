require 'uri'

module Phase5
  class Params
    # Merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}
      @params.merge!(route_params)
      @params.merge!(parse_www_encoded_form(req.body)) if req.body
      @params.merge!(parse_www_encoded_form(req.query_string)) if req.query_string
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # Return deeply nested hash argument format
    # eg: user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      params = {}
      
      key_value_array = URI.decode_www_form(www_encoded_form)
      # At each of the level, create a deaper empty hash, then set the value
      # to the final key
      key_value_array.each do |full_key, value|
        current_level = params
        key_arr = parse_key(full_key)
        key_arr.each_with_index do |key, idx|
          if (idx + 1) == key_arr.count
            current_level[key] = value
          else
            current_level[key] ||= {}
            current_level = current_level[key]
          end
        end
      end
      
      params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\[|\]\[|\]/)
    end
  end
end
