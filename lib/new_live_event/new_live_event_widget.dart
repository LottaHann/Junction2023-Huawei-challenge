import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'new_live_event_model.dart';
export 'new_live_event_model.dart';

class NewLiveEventWidget extends StatefulWidget {
  const NewLiveEventWidget({Key? key}) : super(key: key);

  @override
  _NewLiveEventWidgetState createState() => _NewLiveEventWidgetState();
}

class _NewLiveEventWidgetState extends State<NewLiveEventWidget> {
  late NewLiveEventModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewLiveEventModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Container(
                  width: 461.0,
                  height: 1141.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF3F3939),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-0.08, 0.44),
                    child: Container(
                      width: 345.0,
                      height: 51.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).warning,
                          width: 3.0,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.19, 0.08),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Overall Leader Board    #',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF3F3939),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.86, 0.06),
                            child: Text(
                              '0',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF3F3939),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.05, -0.98),
                child: Text(
                  'BeYolked',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Kantumruy Pro',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1.00, -1.00),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.42,
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: FlutterFlowVideoPlayer(
                    path:
                        'assets/videos/3d-cartoon-man-doing-squats-2022-08-10-14-20-59-utc.mp4',
                    videoType: VideoType.asset,
                    width: MediaQuery.sizeOf(context).width * 0.35,
                    height: MediaQuery.sizeOf(context).height * 0.4,
                    autoPlay: false,
                    looping: true,
                    showControls: false,
                    allowFullScreen: false,
                    allowPlaybackSpeedMenu: false,
                    pauseOnNavigate: false,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.92, -0.76),
                child: Container(
                  width: 112.0,
                  height: 121.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF3F3939),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.27, -1.01),
                        child: Text(
                          'TIME PASSED:',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.06, 0.06),
                        child: FlutterFlowTimer(
                          initialTime: _model.timerMilliseconds,
                          getDisplayTime: (value) =>
                              StopWatchTimer.getDisplayTime(
                            value,
                            hours: false,
                            milliSecond: false,
                          ),
                          controller: _model.timerController,
                          updateStateInterval: Duration(milliseconds: 1000),
                          onChanged: (value, displayTime, shouldUpdate) {
                            _model.timerMilliseconds = value;
                            _model.timerValue = displayTime;
                            if (shouldUpdate) setState(() {});
                          },
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Outfit',
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.10, -0.15),
                child: Container(
                  width: 345.0,
                  height: 206.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF3F3939),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(6.67, 0.00),
                        child: FlutterFlowVideoPlayer(
                          path:
                              'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',
                          videoType: VideoType.network,
                          autoPlay: false,
                          looping: true,
                          showControls: true,
                          allowFullScreen: true,
                          allowPlaybackSpeedMenu: false,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(2.0, 5.0, 0.0, 0.0),
                        child: Container(
                          width: 63.0,
                          height: 29.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFD72929),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1.00, 0.00),
                                child: Text(
                                  ' LIVE',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.74, -0.17),
                                child: Container(
                                  width: 10.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.28),
                child: Container(
                  width: 343.0,
                  height: 64.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF3F3939),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-0.06, -0.39),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                1.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'SQUAT COUNT:',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: FlutterFlowTheme.of(context).warning,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.49, -0.47),
                          child: Text(
                            '0',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: FlutterFlowTheme.of(context).warning,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.94),
                child: Container(
                  width: 345.0,
                  height: 157.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).warning,
                      width: 3.0,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.00, -1.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 0.0),
                          child: Text(
                            'Friend Group Leader Board',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF3F3939),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.12, -0.11),
                        child: Text(
                          '# 1  player1                                          0',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    lineHeight: 1.5,
                                  ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.70, -0.45),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              1.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'SQUAT COUNT:',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: FlutterFlowTheme.of(context).warning,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.12, 0.51),
                        child: Text(
                          '# 3  YOU                                               0',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    lineHeight: 1.5,
                                  ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.12, 0.20),
                        child: Text(
                          '# 2  player                                            0',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    lineHeight: 1.5,
                                  ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.15, 0.83),
                        child: Text(
                          '# 4  keijo                                              0',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    lineHeight: 1.5,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
