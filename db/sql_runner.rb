require( 'pg' )

class SqlRunner

  def self.run( sql, values = [] )
    begin
      # local
      db = PG.connect({ dbname: 'spending_tracker', host: 'localhost' })

      # Heroku
      # db = PG.connect({ dbname: 'daapnvivt153p7', host: 'ec2-174-129-236-147.compute-1.amazonaws.com', port: '5432', user: 'ozfeqtlwraunms', password: '0aaffa677aa1ffda37acac175eaff1cde19e44a7d1d83a7d72338cd3637417b7' })
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
