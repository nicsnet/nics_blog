module ViewResourceMacros
  def has_resource(name, &block)
    before do
      @resource ||= yield
      assign(name, @resource)
      instance_variable_set("@#{name}", @resource)

      if @resource.is_a?(Array)
        view.stub(:collection) { @resource }
        view.stub(:resource_class) {@resource.first.class}
      else
        view.stub(:resource) {@resource}
        view.stub(:resource_class) {@resource.class}
      end
    end
  end
end

RSpec.configure do |config|
  config.extend ViewResourceMacros, type: :view
end
