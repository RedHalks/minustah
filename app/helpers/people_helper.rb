module PeopleHelper
  def person_blood_type_options
    Person.blood_types.keys.map do |key|
      [Person.human_attribute_name("blood_type.#{ key }"), key]
    end
  end
end
