class Task {
  int? taskid;
  int? index;
  String? projectid;
  String? projectname;
  int? ownerid;
  String? ownername;
  String? owneravatar;
  int? executorid;
  String? executorname;
  String? executoravatar;
  String? taskdate;
  String? termdate;
  String? name;
  String? priority;
  String? status;

  Task(
      {this.taskid,
      this.index,
      this.projectid,
      this.projectname,
      this.ownerid,
      this.ownername,
      this.owneravatar,
      this.executorid,
      this.executorname,
      this.executoravatar,
      this.taskdate,
      this.termdate,
      this.name,
      this.priority,
      this.status});

  Task.fromJson(Map<String, dynamic> json) {
    taskid = json['task_id'];
    index = json['index'];
    projectid = json['project_id'];
    projectname = json['project_name'];
    ownerid = json['owner_id'];
    ownername = json['owner_name'];
    owneravatar = json['owner_avatar'];
    executorid = json['executor_id'];
    executorname = json['executor_name'];
    executoravatar = json['executor_avatar'];
    taskdate = json['task_date'];
    termdate = json['term_date'];
    name = json['name'];
    priority = json['priority'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_id'] = taskid;
    data['index'] = index;
    data['project_id'] = projectid;
    data['project_name'] = projectname;
    data['owner_id'] = ownerid;
    data['owner_name'] = ownername;
    data['owner_avatar'] = owneravatar;
    data['executor_id'] = executorid;
    data['executor_name'] = executorname;
    data['executor_avatar'] = executoravatar;
    data['task_date'] = taskdate;
    data['term_date'] = termdate;
    data['name'] = name;
    data['priority'] = priority;
    data['status'] = status;
    return data;
  }
}
