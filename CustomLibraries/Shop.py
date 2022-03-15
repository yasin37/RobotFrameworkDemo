from robot.libraries.BuiltIn import BuiltIn
from robot.api.deco import library, keyword

@library
class Shop():

    def __init__(self):
        self.selLib = BuiltIn().get_library_instance("SeleniumLibrary")

    @keyword
    def hello_world(self):
        print("Hello World")

    @keyword
    def add_items_to_cart_and_checkout(self, productList):
        # Get WebElements
        productTitles = self.selLib.get_webelements("//h4[@class='card-title']")
        i = 1
        for productTitle in productTitles:
            if productTitle.text in productList:
                self.selLib.click_button("xpath:(//div[@class='card-footer'])["+str(i)+"]/button")
                print(productTitle.text)
            i = i +1

        self.selLib.click_link("//a[@class='nav-link btn btn-primary']")

    @keyword
    def verify_items_in_the_checkout_page_and_proceed(self, productList):
        productNames = self.selLib.get_webelements("//div[@class='media-body']/h4/a")
        expected_list = productList
        print("Expected List is " + str(expected_list))
        actual_list = []
        # test_list = ['Iphone', 'Samsung', 'Huawei']

        for productName in productNames:
            actual_list.append(productName.text)

        print("Actual List is " + str(actual_list))
        assert expected_list == actual_list

        self.selLib.click_button("xpath://button[@class='btn btn-success']")

