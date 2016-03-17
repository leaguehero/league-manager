require "rails_helper"

describe ApplicationHelper do
  describe "sets correct alert" do
    it "for success" do
      expect(helper.bootstrap_class_for("success")).to eq("alert-success")
    end
    it "for error" do
      expect(helper.bootstrap_class_for("error")).to eq("alert-danger")
    end
    it "for alert" do
      expect(helper.bootstrap_class_for("alert")).to eq("alert-warning")
    end
    it "for notice" do
      expect(helper.bootstrap_class_for("notice")).to eq("alert-info")
    end
    it "for everything else" do
      expect(helper.bootstrap_class_for("test")).to eq("test")
    end
  end
end
