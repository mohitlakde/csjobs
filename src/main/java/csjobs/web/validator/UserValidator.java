package csjobs.web.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import csjobs.model.User;
import csjobs.model.dao.UserDao;

@Controller
public class UserValidator implements Validator {
	@Autowired
	private UserDao userDao;

	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		User user = (User) target;
		if (!StringUtils.hasText(user.getEmail()))
			errors.rejectValue("email", "errror.field.empty");
		if (!StringUtils.hasText(user.getPassword()))
			errors.rejectValue("password", "errror.field.empty");

		if (!StringUtils.hasText(user.getFirstName()))
			errors.rejectValue("firstName", "errror.field.empty");

		if (!StringUtils.hasText(user.getLastName()))
			errors.rejectValue("lastName", "errror.field.empty");
		if (!StringUtils.hasText(user.getPhone()))
			errors.rejectValue("phone", "errror.field.empty");
		if (!StringUtils.hasText(user.getAddress()))
			errors.rejectValue("address", "errror.field.empty");

	}

}
