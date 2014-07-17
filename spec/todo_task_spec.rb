require 'todo/task'

describe "Todo::Task" do

  before(:each) do
    @description = "my test task"
    @tags = ["tag1", "tag2"]
    @task = Todo::Task.new(@description, ["tag1", "tag2"])
  end

  it "should return a hash" do
    @task_hash = @task.to_h
    expect(@task_hash["taskid"]).not_to be_empty
    expect(@task_hash["created_at"]).not_to be_empty
    expect(@task_hash["description"]).to eq(@description)
    expect(@task_hash["tags"]).to eq(@tags)
  end

end
