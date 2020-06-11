require 'pry'
class Pokemon

    attr_accessor :name, :type
    attr_reader :id, :db

    def initialize (id: "nil", name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        pokemon = Pokemon.new(name: name, type: type, db: db)
        sql = <<-SQL 
            INSERT INTO pokemon (name, type)
            VALUES (?, ?);
            SQL
        pokemon.db.execute(sql, pokemon.name, pokemon.type)
        @id = pokemon.db.execute("SELECT last_insert_rowid() FROM pokemon;")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id == ?;
            SQL
        pokemon = db.execute(sql, id).map do |pokemon| 
            self.new(id: pokemon[0], name: pokemon[1], type: pokemon[2], db: db)
        end
        pokemon.first
    end
end
