Rails.application.config.filter_parameters += %i[
  password password_confirmation token secret private_key authorization
  enrollment_token credential
]
