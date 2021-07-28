package opus;

import cpp.UInt8;
import cpp.RawPointer;
import cpp.Pointer;

/** No error @hideinitializer*/
final OPUS_OK = 0;

/** One or more invalid/out of range arguments @hideinitializer*/
final OPUS_BAD_ARG = -1;

/** Not enough bytes allocated in the buffer @hideinitializer*/
final OPUS_BUFFER_TOO_SMALL = -2;

/** An internal error was detected @hideinitializer*/
final OPUS_INTERNAL_ERROR = -3;

/** The compressed data passed is corrupted @hideinitializer*/
final OPUS_INVALID_PACKET = -4;

/** Invalid/unsupported request number @hideinitializer*/
final OPUS_UNIMPLEMENTED = -5;

/** An encoder or decoder structure is invalid or already freed @hideinitializer*/
final OPUS_INVALID_STATE = -6;

/** Memory allocation has failed @hideinitializer*/
final OPUS_ALLOC_FAIL = -7;

/** @hideinitializer */
final OPUS_APPLICATION_VOIP = 2048;

/** Best for broadcast/high-fidelity application where the decoded audio should be as close as possible to the input
 * @hideinitializer */
final OPUS_APPLICATION_AUDIO = 2049;

/** Only use when lowest-achievable latency is what matters most. Voice-optimized modes cannot be used.
 * @hideinitializer */
final OPUS_APPLICATION_RESTRICTED_LOWDELAY = 2051;

final OPUS_SIGNAL_VOICE = 3001; /**< Signal being encoded is voice */

final OPUS_SIGNAL_MUSIC = 3002; /**< Signal being encoded is music */

final OPUS_BANDWIDTH_NARROWBAND = 1101; /**< 4 kHz bandpass @hideinitializer*/

final OPUS_BANDWIDTH_MEDIUMBAND = 1102; /**< 6 kHz bandpass @hideinitializer*/

final OPUS_BANDWIDTH_WIDEBAND = 1103; /**< 8 kHz bandpass @hideinitializer*/

final OPUS_BANDWIDTH_SUPERWIDEBAND = 1104; /**<12 kHz bandpass @hideinitializer*/

final OPUS_BANDWIDTH_FULLBAND = 1105; /**<20 kHz bandpass @hideinitializer*/

final OPUS_FRAMESIZE_ARG = 5000; /**< Select frame size from the argument (default) */

final OPUS_FRAMESIZE_2_5_MS = 5001; /**< Use 2.5 ms frames */

final OPUS_FRAMESIZE_5_MS = 5002; /**< Use 5 ms frames */

final OPUS_FRAMESIZE_10_MS = 5003; /**< Use 10 ms frames */

final OPUS_FRAMESIZE_20_MS = 5004; /**< Use 20 ms frames */

final OPUS_FRAMESIZE_40_MS = 5005; /**< Use 40 ms frames */

final OPUS_FRAMESIZE_60_MS = 5006; /**< Use 60 ms frames */

final OPUS_FRAMESIZE_80_MS = 5007; /**< Use 80 ms frames */

final OPUS_FRAMESIZE_100_MS = 5008; /**< Use 100 ms frames */

final OPUS_FRAMESIZE_120_MS = 5009; /**< Use 120 ms frames */

@:keep
@:include('linc_opus.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('opus'))
#end
extern class Opus {
    @:native("opus_encoder_get_size")
	public static function encoder_get_size(channels:Int):Int;

    @:native("opus_decoder_get_size")
	public static function decoder_get_size(channels:Int):Int;

    @:native("opus_encoder_init")
    public static function encoder_init(st:Pointer<OpusEncoder>, Fs:Int, channels:Int, application:Int):Int;

    @:native("opus_decoder_init")
    public static function decoder_init(st:Pointer<OpusDecoder>, Fs:Int, channels:Int):Int;

    @:native("opus_encoder_create")
    public static function encoder_create(Fs:Int, channels:Int, application:Int, error:RawPointer<Int>):Pointer<OpusEncoder>;

    @:native("opus_decoder_create")
    public static function decoder_create(Fs:Int, channels:Int,  error:RawPointer<Int>):Pointer<OpusDecoder>;


    @:native("opus_encode")
    public static function encode(st:Pointer<OpusEncoder>, pcm:RawPointer<cpp.Int16>, frame_size:Int, data:RawPointer<UInt8>, max_data_bytes:Int):Int;
   

    @:native("opus_decode")
    public static function decode(st:Pointer<OpusDecoder>, data:RawPointer<UInt8>, len:Int, pcm:RawPointer<cpp.Int16>, frame_size:Int, decode_fec:Int):Int;


    @:native("opus_decode_float")
    public static function decode_float(st:Pointer<OpusDecoder>, data:RawPointer<UInt8>, len:Int, pcm:RawPointer<Float>, frame_size:Int, decode_fec:Int):Int;

    @:native("opus_encode_float")
    public static function encode_float(st:Pointer<OpusEncoder>, pcm:RawPointer<Float>, frame_size:Int, data:RawPointer<UInt8>, max_data_bytes:Int):Int;

    @:native("opus_encoder_destroy")
    public static function encoder_destory(st:Pointer<OpusEncoder>):Void;

    @:native("opus_decoder_destroy")
    public static function decoder_destory(st:Pointer<OpusDecoder>):Void;

    @:native("opus_packet_parse")
    public static function packet_parse(data:RawPointer<UInt8>, len:Int, out_toc:RawPointer<UInt8>, frames:RawPointer<UInt8>, size:Array<cpp.Int16>, payload_offset:RawPointer<Int>):Int;

    @:native("opus_packet_get_bandwidth")
    public static function get_bandwidth(data:RawPointer<UInt8>):Int;

    @:native("opus_packet_get_samples_per_frame")
    public static function packet_get_samples_per_frame(data:RawPointer<UInt8>, Fs:Int):Int;

    @:native("opus_packet_get_nb_channels")
    public static function packet_get_nb_channels(data:RawPointer<UInt8>):Int;

    @:native("opus_packet_get_nb_frames")
    public static function packet_get_nb_frames(packet:Array<UInt8>, len:Int):Int;

    @:native("opus_packet_get_nb_samples")
    public static function packet_get_nb_samples(packet:Array<UInt8>, len:Int, Fs:Int):Int;
    

    @:native("opus_decoder_get_nb_samples")
    public static function decoder_get_nb_samples(dec:Pointer<OpusDecoder>, packet:Array<UInt8>, len:Int):Int;

    @:native("opus_pcm_soft_clip")
    public static function pcm_soft_clip(pcm:RawPointer<Float>, frame_size:Int, channels:Int, softclip_mem:RawPointer<Float>):Int;

} // Opus


@:keep
@:structAccess
@:include('opus.h')
@:native("opus_decoder")
extern class OpusDecoder {
    public var celt_dec_offset:Int;
    public var silk_dec_offset:Int;
    public var channels:Int;
    public var Fs:Int;
    public var decode_gain:Int;
    public var arch:Int;
    public var stream_channels:Int;
    public var bandwidth:Int;
    public var mode:Int;
    public var prev_mode:Int;
    public var frame_size:Int;
    public var prev_redundancy:Int;
    public var last_packet_duration:Int;
    public var rangeFinal:Int;
}


@:keep
@:structAccess
@:include('opus.h')
@:native("opus_encoder")
extern class OpusEncoder{
    public var celt_enc_offset:Int;
    public var silk_enc_offset:Int;
    public var application:Int;
    public var channels:Int;
    public var delay_compensation:Int;
    public var force_channels:Int;
    public var signal_type:Int;
    public var user_bandwidth:Int;
    public var max_bandwidth:Int;
    public var user_forced_mode:Int;
    public var voice_ratio:Int;
    public var Fs:Int;
    public var use_vbr:Int;
    public var vbr_constraint:Int;
    public var variable_duration:Int;
    public var bitrate_bps:Int;
    public var user_bitrate_bps:Int;
    public var lsb_depth:Int;
    public var encoder_buffer:Int;
    public var lfe:Int;
    public var arch:Int;
    public var use_dtx:Int;
    public var stream_channels:Int;
    public var hybrid_stereo_width_Q14:Int;
    public var variable_HP_smth2_Q15:Int;
    public var prev_HB_gain:OpusVal16;
    public var hp_mem:Array<OpusVal32>;
    public var mode:Int;
    public var prev_mode:Int;
    public var prev_channels:Int;
    public var prev_framesize:Int;
    public var bandwidth:Int;
    public var auto_bandwidth:Int;
    public var silk_bw_switch:Int;
    public var first:Int;
    public var energy_masking:RawPointer<OpusVal16>;
    public var delay_buffer:Array<OpusVal16>;
    public var nonfinal_frame:Int;
    public var rangeFinal:cpp.UInt32;
}


@:keep
@:structAccess
@:include('opus.h')
@:native("opus_val32")
extern class OpusVal32{}

@:keep
@:structAccess
@:include('opus.h')
@:native("opus_val16")
extern class OpusVal16{}

@:keep
@:structAccess
@:include('opus.h')
@:native("StereoWidthState")
extern class StereoWidthState{
    public var XX:OpusVal32;
    public var  XY:OpusVal32;
    public var YY:OpusVal32;
    public var smoothed_width:OpusVal16;
    public var max_follower:OpusVal16;
}

@:keep
@:structAccess
@:include('opus_multistream.h')
extern class OpusMultistream {
	@:native("opus_multistream_encoder_get_size")
	public static function encoder_get_size(streams:Int, coupled_streams:Int):Int;
	@:native("opus_multistream_surround_encoder_get_size")
	public static function surround_encoder_get_size(channels:Int, mapping_family:Int):Int;

	@:native("opus_multistream_encoder_create")
	public static function encoder_create(Fs:Int, channels:Int, streams:Int, coupled_streams:Int, mapping:cpp.RawPointer<UInt8>, application:Int,
		error:cpp.RawPointer<Int>):Pointer<OpusMSEncoder>;

	@:native("opus_multistream_surround_encoder_create")
	public static function surround_encoder_create(Fs:Int, channels:Int, mapping_family:Int, streams:cpp.RawPointer<Int>, coupled_streams:cpp.RawPointer<Int>,
		mapping:cpp.RawPointer<UInt8>, application:Int, error:cpp.RawPointer<Int>):Pointer<OpusMSEncoder>;

	@:native("opus_multistream_encoder_init")
	public static function encoder_init(st:Pointer<OpusMSEncoder>, Fs:Int, channels:Int, streams:Int, coupled_streams:Int, mapping:cpp.RawPointer<UInt8>,
		application:Int):Int;

	@:native("opus_multistream_surround_encoder_init")
	public static function surround_encoder_init(st:Pointer<OpusMSEncoder>, Fs:Int, channels:Int, mapping_family:Int, streams:cpp.RawPointer<Int>,
		coupled_streams:cpp.RawPointer<Int>, mapping:cpp.RawPointer<UInt8>, application:Int):Int;

	@:native("opus_multistream_encode")
	public static function encode(st:Pointer<OpusMSEncoder>, pcm:cpp.RawPointer<cpp.Int16>, frame_size:Int, data:cpp.RawPointer<UInt8>, max_data_bytes:Int):Int;

	@:native("opus_multistream_encode_float")
	public static function encode_float(st:Pointer<OpusMSEncoder>, pcm:cpp.RawPointer<Float>, frame_size:Int, data:cpp.RawPointer<UInt8>, max_data_bytes:Int):Int;

	@:native("opus_multistream_encoder_destroy")
	public static function encoder_destroy(st:Pointer<OpusMSEncoder>):Void;

	@:native("opus_multistream_decoder_get_size")
	public static function decoder_get_size(streams:Int, coupled_streams:Int):Int;

	@:native("opus_multistream_decoder_create")
	public static function decoder_create(Fs:Int, channels:Int, streams:Int, coupled_streams:Int, mapping:cpp.RawPointer<UInt8>,
		error:cpp.RawPointer<Int>):Pointer<OpusMSDecoder>;

	@:native("opus_multistream_decoder_init")
	public static function decoder_init(st:Pointer<OpusMSDecoder>, Fs:Int, channels:Int, streams:Int, coupled_streams:Int, mapping:cpp.RawPointer<UInt8>):Int;

	@:native("opus_multistream_decode")
	public static function decode(st:Pointer<OpusMSDecoder>, data:cpp.RawPointer<UInt8>, len:Int, pcm:cpp.RawPointer<cpp.Int16>, frame_size:Int, decode_fec:Int):Int;

	@:native("opus_multistream_decode_float")
	public static function decode_float(st:Pointer<OpusMSDecoder>, data:cpp.RawPointer<UInt8>, len:Int, pcm:cpp.RawPointer<Float>, frame_size:Int,
		decode_fec:Int):Int;

    @:native("opus_multistream_decoder_ctl")
    public static function decoder_ctl(st:Pointer<OpusMSDecoder>, request:Int):Int;

	@:native("opus_multistream_decoder_destroy")
	public static function decoder_destroy(st:Pointer<OpusMSDecoder>):Void;
}

@:keep
@:structAccess
@:include('opus_private.h')
@:native("ChannelLayout")
extern class ChannelLayout {
	public var nb_channels:Int;
	public var nb_streams:Int;
	public var nb_coupled_streams:Int;
	public var mapping:Array<UInt8>;
}

@:keep
@:structAccess
@:include('opus_private.h')
@:native("OpusMSDecoder")
extern class OpusMSDecoder {
	public var layout:ChannelLayout;
}

@:include("opus_private.h")
extern class TMappingType {}

@:keep
@:include("opus_private.h")
extern enum abstract MappingType(TMappingType) from TMappingType to TMappingType {
	@:native("MAPPING_TYPE_NONE")
	public final MAPPING_TYPE_NONE:TMappingType;
	@:native("MAPPING_TYPE_SURROUND")
	public final MAPPING_TYPE_SURROUND:TMappingType;
	@:native("MAPPING_TYPE_AMBISONICS")
	public final MAPPING_TYPE_AMBISONICS:TMappingType;
}

@:keep
@:structAccess
@:include('opus_private.h')
@:native("OpusMSEncoder")
extern class OpusMSEncoder {
	public var layout:ChannelLayout;
	public var arch:Int;
	public var lfe_stream:Int;
	public var application:Int;
	public var variable_duration:Int;
	public var bitrate_bps:cpp.Int32;
	public var mapping_type:MappingType;
}
