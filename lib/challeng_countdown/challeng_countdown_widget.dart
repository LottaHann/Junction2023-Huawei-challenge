import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'challeng_countdown_model.dart';
export 'challeng_countdown_model.dart';

class ChallengCountdownWidget extends StatefulWidget {
  const ChallengCountdownWidget({Key? key}) : super(key: key);

  @override
  _ChallengCountdownWidgetState createState() =>
      _ChallengCountdownWidgetState();
}

class _ChallengCountdownWidgetState extends State<ChallengCountdownWidget> {
  late ChallengCountdownModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChallengCountdownModel());
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
        backgroundColor: FlutterFlowTheme.of(context).primary,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondary,
          ),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.00, -0.80),
                child: Text(
                  'BeYolked',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Kantumruy Pro',
                        color: FlutterFlowTheme.of(context).alternate,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, -0.48),
                child: Text(
                  'Squats',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).tertiary,
                        fontSize: 30.0,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, -0.60),
                child: Text(
                  'Challenge:',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).tertiary,
                        fontSize: 30.0,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, -0.60),
                child: Text(
                  'Challenge:',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).tertiary,
                        fontSize: 30.0,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, -0.60),
                child: Text(
                  'Challenge:',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).tertiary,
                        fontSize: 30.0,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.10, -0.20),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: FlutterFlowExpandedImageView(
                          image: Image.asset(
                            'assets/images/Screenshot_2.png',
                            fit: BoxFit.contain,
                          ),
                          allowRotation: false,
                          tag: 'imageTag',
                          useHeroAnimation: true,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'imageTag',
                    transitionOnUserGestures: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/Screenshot_2.png',
                        width: 213.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.45),
                child: Text(
                  'Camera:',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).alternate,
                        fontSize: 25.0,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.40, 0.30),
                child: Text(
                  '3',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).alternate,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.45, 0.30),
                child: Text(
                  'SEC',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).alternate,
                        fontSize: 30.0,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.15, 0.30),
                child: Text(
                  '4',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).alternate,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.15, 0.30),
                child: Text(
                  'MIN',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).alternate,
                        fontSize: 30.0,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.15),
                child: Text(
                  'Challenge starting in...',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).alternate,
                        fontSize: 30.0,
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
