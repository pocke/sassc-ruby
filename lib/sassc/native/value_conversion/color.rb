module SassC
  module Native
    module ValueConversion
      class Color < Base
        def to_native
          Native::make_color(
            @value.red,
            @value.green,
            @value.blue,
            @value.alpha
          )
        end
      end
    end
  end
end
