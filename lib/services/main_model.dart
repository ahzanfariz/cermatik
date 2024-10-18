// import 'package:foodly/services/activity_service.dart';
import './complain_question_service.dart';
import 'package:quizzie_thunder/services/score_service.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:socket_io_client/socket_io_client.dart';

import './user_services.dart';
import './product_services.dart';
import './subscription_service.dart';
import './category_service.dart';
import './services.dart';

class MainModel extends Model
    with
        UserService,
        Services,
        CategoryService,
        ProductService,
        SubscriptionService,
        ScoreService,
        ComplainQuestionService
// MemberService
{}
