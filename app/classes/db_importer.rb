# This class will import a file to PG db
class DbImporter

  def self.import_simple_table(name, columns, file, options = {})
    delimiter          = options[:delimiter] || ","
    ignore_header      = options[:ignore_header]
    delete_records     = options[:delete_records]
    unique_batch_value = options[:unique_batch_value]
    unique_batch_key   = options[:unique_batch_key]

    query = %{
      BEGIN;
      #{'DELETE FROM %s WHERE %s=\'%s\';' % [name, unique_batch_key, unique_batch_value] if delete_records}
      COPY #{name} (#{columns.map{|c| '"%s"' % c}.join(",")})
      FROM '#{file}'
      DELIMITER '#{delimiter}'
      #{ignore_header ? '' : 'CSV HEADER'}
      ;COMMIT;
    }
    ActiveRecord::Base.connection.execute(query)
  end

end
