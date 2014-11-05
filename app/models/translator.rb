class Translator
  @instance = nil
  class << self
    def instance
      @instance ||= BingTranslator.new(
	"DVT_1112","ke8WcDprw2Fo9gLWViwYOrxWHMs/lkGg6en/ONOiMvk=")
    end
  end
end
