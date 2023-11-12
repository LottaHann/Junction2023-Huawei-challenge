import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'live_event_model.dart';
export 'live_event_model.dart';

class LiveEventWidget extends StatefulWidget {
  const LiveEventWidget({
    Key? key,
    String? reps,
  })  : this.reps = reps ?? '1',
        super(key: key);

  final String reps;

  @override
  _LiveEventWidgetState createState() => _LiveEventWidgetState();
}

class _LiveEventWidgetState extends State<LiveEventWidget> {
  late LiveEventModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LiveEventModel());
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

    return StreamBuilder<List<EventsRecord>>(
      stream: queryEventsRecord(
        queryBuilder: (eventsRecord) => eventsRecord.where(
          'status',
          isNotEqualTo: 'passed',
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFFFC24B),
                  ),
                ),
              ),
            ),
          );
        }
        List<EventsRecord> liveEventEventsRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final liveEventEventsRecord = liveEventEventsRecordList.isNotEmpty
            ? liveEventEventsRecordList.first
            : null;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              appBar: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                automaticallyImplyLeading: false,
                title: Text(
                  liveEventEventsRecord!.eventType,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                ),
                actions: [],
                centerTitle: false,
                elevation: 2.0,
              ),
              body: SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FlutterFlowVideoPlayer(
                                  path:
                                      'assets/videos/3d-cartoon-man-doing-squats-2022-08-10-14-20-59-utc.mp4',
                                  videoType: VideoType.asset,
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.3,
                                  autoPlay: true,
                                  looping: true,
                                  showControls: false,
                                  allowFullScreen: false,
                                  allowPlaybackSpeedMenu: false,
                                  lazyLoad: true,
                                  pauseOnNavigate: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          height: MediaQuery.sizeOf(context).height * 0.3,
                          child: custom_widgets.ImagePoseRecTest(
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            height: MediaQuery.sizeOf(context).height * 0.3,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.00, 0.00),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reps: ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 24.0,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  FFAppState().reps.toString(),
                                  '0',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 24.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Leaderboard',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 0.2,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: StreamBuilder<UsersRecord>(
                            stream:
                                UsersRecord.getDocument(currentUserReference!),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFFFFC24B),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final listViewUsersRecord = snapshot.data!;
                              return ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                children: [
                                  ListTile(
                                    title: Text(
                                      listViewUsersRecord.email,
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge,
                                    ),
                                    subtitle: Text(
                                      'Subtitle goes here...',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 20.0,
                                    ),
                                    tileColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    dense: false,
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Title',
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge,
                                    ),
                                    subtitle: Text(
                                      'Subtitle goes here...',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 20.0,
                                    ),
                                    tileColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    dense: false,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
