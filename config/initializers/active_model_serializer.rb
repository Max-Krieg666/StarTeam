ActiveModel::Serializer.config.default_includes = '**'
ActiveModel::Serializer.config.adapter = :json

ActiveModelSerializers.logger = ActiveSupport::TaggedLogging.new(
  ActiveSupport::Logger.new('/dev/null')
)
