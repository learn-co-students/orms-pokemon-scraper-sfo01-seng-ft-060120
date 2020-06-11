class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize (id:, name:, type:, db:) # .initialize is initialized with keyword arguments of id, name, type and db
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db) # .save saves an instance of a pokemon with the correct id
        db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    end
    
    def self.find(id_number, db) # .find finds a pokemon from the database by their id number and returns a new Pokemon object
        pokemon = db.execute("SELECT * FROM pokemon WHERE id = ?", id_number).flatten
        Pokemon.new(id: pokemon[0], name: pokemon[1], type: pokemon[2], db: db)
    end

end