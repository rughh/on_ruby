# By creating custom input class finder, you can change how input classes  are looked up.
# For example you can make it to search for TextInputFilter instead of TextInput.
# See # TODO: add link # for more information
# NOTE: this behavior will be default from Formtastic 4.0
Formtastic::FormBuilder.input_class_finder = Formtastic::InputClassFinder

# By creating custom action class finder, you can change how action classes are looked up.
# For example you can make it to search for MyButtonAction instead of ButtonAction.
# See # TODO: add link # for more information
# NOTE: this behavior will be default from Formtastic 4.0
Formtastic::FormBuilder.action_class_finder = Formtastic::ActionClassFinder
