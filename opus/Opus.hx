package opus;

@:keep
@:include('linc_opus.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('opus'))
#end
extern class Opus {

    //     //external native function definition
    //     //can be wrapped in linc::libname or call directly
    //     //and the header for the lib included in linc_empty.h

    // @:native('linc::empty::example')
    // static function example() : Int;

    //     //inline functions can be used as wrappers
    //     //and can be useful to juggle haxe typing to or from the c++ extern

    // static inline function inline_example() : Int {
    //     return untyped __cpp__('linc::empty::example()');
    // }

    // @:native('linc::empty::example')
    // private static function _internal_example() : Int;
    // static inline function other_inline_example() : Int {
    //     return _internal_example();
    // }

} //Opus