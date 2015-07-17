module MLBGameday
  class Team
    attr_reader :id, :name, :city, :league, :division, :code, :file_code

    def initialize(opts = {})
      @id        = opts[:id]
      @name      = opts[:name]
      @city      = opts[:city]
      @league    = opts[:league]
      @division  = opts[:division]
      @alt_names = opts[:alt_names]
      @code      = opts[:code]
      @file_code = opts[:file_code]
    end
    
    def full_name
      "#{city} #{name}"
    end
    
    def names
      @names ||= (implicit_names + alt_names).uniq
    end
    
    def is_called?(name)
      names.include?(name.downcase)
    end

    # So we don't get huge printouts
    def inspect
      %(#<MLBGameday::Team @name="#{@name}">)
    end
    
    private
    def alt_names
      @alt_names ||= []
    end
    
    def implicit_names
      result = strict_names << code.downcase
      result << city.downcase unless ["New York", "Chicago"].include?(city)
      
      result
    end
    
    def strict_names
      [name, full_name].map(&:downcase)
    end
  end
end
