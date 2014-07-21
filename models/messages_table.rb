class MessagesTable

  def initialize(input)
    @database_connection = input
  end

  def add_message(name, message)
    insert = <<-QUERY
      INSERT INTO messages (name, message)
      VALUES ('#{name}', '#{message}')
    QUERY

    @database_connection.sql(insert)
  end

  def get_messages
    select = <<-QUERY
      SELECT *
      FROM messages
    QUERY

    @database_connection.sql(select)
  end

end