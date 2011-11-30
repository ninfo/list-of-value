module ListOfValue
  class ListOfValue < ActiveRecord::Base
    #
    # get values from list_of_values table
    #
    # params string utype is the list_of_value table lov_type
    # params hash opt it can use some keys:
    # opt:
    #   :for => one of ['hash', 'select', 'radio'] is return type
    #
    def self.get_values(utype, opt = {})

      list = {}
      opt[:locale] = I18n.default_locale if !opt.has_key?('locale')
      opt[:get_one] = false if !opt.has_key?('get_one')
      opt[:for] = 'hash' if !opt.has_key?(:for)

      ret = self.where("lov_type=? AND locale=?",utype,opt[:locale])

      if opt[:for] == 'select'
        ret.map{|r| [r.display_value, r.value]}
      elsif opt[:for] == 'radio'
        ret.each { |e| list[e.display_value] = e.value }
        list
      elsif opt[:for] == 'hash'
        ret.each { |e| list[e.value] = e.display_value }
        list
      end
    end
  end
end
