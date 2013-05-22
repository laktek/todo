require 'todo/list'

describe "Todo::List" do

  describe "filtering by tag" do
    before(:each) do
      @todolist  = Todo::List["dummy task" => ["added:31-07-2008", "important"], "Buy milk" => ["important", "home"]]
      @list_with_task_tagged_home = {"Buy milk" => ["important", "home"]}
    end

    it "should return matched items by tag" do
      @todolist.tagged("important").should == @todolist
    end

    it "should filter items by tags" do
      @todolist.tagged("home").should == @list_with_task_tagged_home
    end

    it "should be able to apply chain of filters" do
      @todolist.tagged("important").tagged("home").should == @list_with_task_tagged_home
    end

  end

  describe "add" do
    before(:each) do
      @todolist =Todo::List["dummy task" => ["added:31-07-2008", "important"]]
      @after_list  =Todo::List["dummy task" => ["added:31-07-2008", "important"], "Buy milk" => []]
    end

    it "should add new item to the exisitng task list" do
      @todolist.add("Buy milk").should == @after_list
    end

    it "should accept list of tags with the item" do
      list_with_tags_added = {"dummy task" => ["added:31-07-2008", "important"], "Buy milk" => ["important", "assigned:mom"]}

      @todolist.add("Buy milk", "important", "assigned:mom").should == list_with_tags_added
    end

  end

  describe "remove" do
    before(:each) do
      @todolist  =Todo::List["dummy task" => ["added:31-07-2008", "important"], "Buy milk" => []]
      @after_list =Todo::List["dummy task" => ["added:31-07-2008", "important"]]
    end

    it "should remove a task by name" do
      @todolist.remove("Buy milk").should == @after_list
    end

    it "should remove a task by its index" do
      @todolist.remove(2).should == @after_list
    end

    it "should return nil if the task is not found" do
      @todolist.remove("not done").should == nil
    end

  end

end