def enter_text_in_all_text_inputs(value)
	$driver.inputs.each do |element|
		element.send_keys(value) if element.visible?
	end
end