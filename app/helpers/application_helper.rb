module ApplicationHelper

	def status_tag(boolean, options={})
		options[:true_text]  ||= ''
		options[:false_text] ||= ''

		if boolean
			content_tag(:span, options[:true_text], :class => 'fa fa-check')
		else
			content_tag(:span, options[:false_text], :class => 'fa fa-times')
		end

	end

end
