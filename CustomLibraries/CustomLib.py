import random
import string

__version__ = '1.0.0'

class  CustomLib(object):

    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def get_random_name(self, email_length):
        letters = string.ascii_lowercase
        generate_email = ''.join(random.choice(letters) for i in range(email_length))
        return generate_email

    def generate_random_emails(self, length):
        domains = ["hotmail.com", "gmail.com", "aol.com", "mail.com", "mail.kz", "yahoo.com"]

        emailAddress = self.get_random_name(length) + '@' + random.choice(domains)
        return emailAddress

    def generate_random_pass(self, pass_length):
        generate_pass = ''.join(random.choice(string.ascii_lowercase + string.digits) for i in range(pass_length))
        return generate_pass





