import 'package:pman/src/entities/approval.dart';
import 'package:pman/src/entities/approval_category.dart';
import 'package:pman/src/entities/base_response.dart';
import 'package:pman/src/entities/dev_source.dart';
import 'package:pman/src/entities/menus.dart';
import 'package:pman/src/entities/mytask.dart';
import 'package:pman/src/entities/project_leader.dart';
import 'package:pman/src/entities/task_status.dart';
import 'package:pman/src/utils/common/app_constanta_color.dart';
import 'package:pman/src/utils/common/app_constanta_images.dart';
import 'package:pman/src/utils/common/app_constanta_lists.dart';
import 'package:pman/src/utils/common/app_constanta_sizes.dart';
import 'package:pman/src/utils/common/app_constanta_strings.dart';

class AppConstanta {
  static AppConstantaImages images = AppConstantaImages();
  static AppConstantaStrings strings = AppConstantaStrings();
  static AppConstantaList lists = AppConstantaList();
  static AppConstantaSizes sizes = AppConstantaSizes();
  static AppConstantaColors colors = AppConstantaColors();
}

final mytaskEmpty = MyTaskEntity(
  bitSuccess: false,
  objData: [],
  txtMessage: "",
  txtStackTrace: "",
  txtGuid: "",
);

final mytaskObjEmpty = MyTaskObjData(
    intProjectId: 0,
    intProjectPlanId: 0,
    intProjectObjectiveId: 0,
    txtProjectCode: "",
    txtProjectName: "",
    txtDeptCode: "",
    txtDocReference: "",
    txtProjectObjectiveDesc: "",
    txtProjectLeader: "",
    txtProjectLeaderName: "",
    intProjectTaskId: 0,
    txtResourceCode: "",
    txtResourceName: "",
    txtTaskDescription: "",
    txtMilestone: "",
    dtmPlanStartDate: "",
    dtmPlanEndDate: "",
    txtStatus: "",
    bitFinalProceed: false,
    bitHold: false,
    txtNextStatus: "",
    txtNote: "",
    intDueProgressValue: 0,
    intProgressValue: 0,
    txtProgressValue: "",
    page: 0);

const taskStatusEmpty = TaskStatusEntity(
  bitSuccess: false,
  objData: [],
  txtMessage: "",
  txtStackTrace: "",
  txtGuid: "",
);

final baseResponseEmpty = BaseResponseEntity(
  bitSuccess: false,
  txtMessage: "",
  txtStackTrace: "",
  txtGuid: "",
);

const projectLeaderEmpty =
    ProjectLeaderObjData(txtPicStreamName: "", txtPicStreamNik: "");

const devSourceDataEmpty = DevSourceObjData(
  txtNik: "",
  txtResourceName: "",
  intMappingResourceDetailId: 0,
  intMappingResourceHeaderId: 0,
  txtGuid: "",
  bitActive: false,
  txtInsertedBy: "",
  txtUpdatedBy: "",
  dtmInsertedDate: "",
  dtmUpdatedDate: "",
  txtDepartmentCode: "",
);

final approvalEmpty = ApprovalEntity(
  bitSuccess: false,
  objData: [],
  txtMessage: "",
  txtStackTrace: "",
  txtGuid: "",
);

const approvalObjDataEmpty = ApprovalObjData(
  txtTeamSquads: "",
  intProjectId: 0,
  txtProjectObjectiveDesc: "",
  txtProjectName: "",
  txtMilestone: "",
  intProjectTaskId: 0,
  txtTaskDescription: "",
  txtCategory: "",
  txtCategoryType: "",
  txtDeptCode: "",
  txtDeptName: "",
  txtResourceCode: "",
  txtResourceName: "",
  dtmPlanStartDate: "",
  dtmPlanEndDate: "",
  intLeadTime: 0,
  page: 0,
  isChecked: false,
);

const approvalCategoryLOVEmpty = ApprovalCategoryObjData(
  intDetailId: 0,
  txtDescription: "",
  txtMilestone: "",
);

const taskStatusObjDataEmpty = TaskStatusObjData(
  id: 0,
  name: "",
  progress: 0.0,
  finalFlag: false,
);

final menus = <MenuEntity>[
  const MenuEntity(
    intMenuId: 0,
    txtMenuCode: "",
    txtMenuName: "My Task",
    txtDescription: "",
    txtLink: "",
    bitActive: true,
    txtIcon: "",
    txtGuid: "",
    itemList: [],
  ),
];
