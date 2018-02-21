require 'watir'
require 'selenium-webdriver'
require 'minitest/test'

module Watir
  module Locators
    class Element
      class SelectorBuilder
        alias :old_normalize_selector :normalize_selector

        def normalize_selector(how, what)
          case how
            when :'ng-model'
              [how, what]
            else
              old_normalize_selector(how, what)
          end
        end
      end
    end
  end
end

World(MiniTest::Assertions)
