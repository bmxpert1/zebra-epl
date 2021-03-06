module Zebra
  module Epl
    module Printable
      class MissingAttributeError < StandardError
        def initialize(message)
          super("Can't print if #{message}")
        end
      end

      attr_reader :position, :x, :y
      attr_accessor :data

      def initialize(options = {})
        options.each_pair { |attribute, value| self.__send__ "#{attribute}=", value }
      end

      def position=(coords)
        @position, @x, @y = coords, coords[0], coords[1]
      end

      def rotation=(rot)
        Rotation.validate_rotation rot
        @rotation = rot
      end

      def rotation
        @rotation || Rotation::NO_ROTATION
      end

      private

      def check_attributes
        raise MissingAttributeError.new("the X value is not given") unless @x
        raise MissingAttributeError.new("the Y value is not given") unless @y
        raise MissingAttributeError.new("the data to be printed is not given") unless @data
      end
    end
  end
end
