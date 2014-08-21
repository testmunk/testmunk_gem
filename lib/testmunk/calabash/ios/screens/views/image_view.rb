require 'testmunk/calabash/ios/screens/views/view'


module Testmunk
  module IOS

    class ImageView < View

      def wait_for_none_animating(timeout = 10)
        log 'wait for none animating', "#{@uiquery}, timeout: #{timeout}"

        wait_for({:timeout => timeout, :retry_frequency => 0.3}) { not is_animating? }
      end

      def wait_for_animation(timeout = 10)
        log 'wait for animation', "#{@uiquery}, timeout: #{timeout}"

        wait_for({:timeout => timeout, :retry_frequency => 0.3}) { is_animating? }
      end

      def is_animating?
        if exists?
          query(@uiquery).first['description'].include?('animations')
        else
          false
        end
      end
    end

  end
end