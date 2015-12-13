module ApplicationHelper
  def bootstrap_class_for(type)
      case type
        when "success"
          "alert-success" #Green
        when "error"
          "alert-danger" #Red
        when "alert"
          "alert-warning" #Yellow
        when "notice"
          "alert-info" #Blue
        else
          type.to_s
      end
  end
end
