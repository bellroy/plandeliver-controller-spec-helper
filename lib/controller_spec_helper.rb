module ControllerSpecHelper

  # check if a request went as expected
  #
  # Parameters:
  # => redirect: Checks whether the action redirected to <value>_path (e.g. "root_path")
	# => template: Checks whether the action rendered the given template (e.g. "new")
	# => flash: Requires an array of exptected flash messages (e.g. [:error, :notice])
	# => assigned: Requires an hash of variable value pairs. These are then specced against the
	#    expression "assigns[:#{var}].should#{value}" (e.g. { :number => " be_nil"} or { :name => "not be_empty"})
  def do_request(*args, &block)
    yield
    
    options = args.extract_options!
    response.should(render_template(options[:template])) if options[:template]
    response.should(redirect_to(eval("#{options[:redirect]}_path"))) if options[:redirect]
    
    options[:flash].each { |message| flash[message].should_not be_nil } if options[:flash]
    options[:vars].each { |var, match| eval "assigns[:#{var}].should#{match}" } if options[:vars]
  end
end