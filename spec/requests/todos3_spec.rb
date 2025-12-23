require "rails_helper"

RSpec.describe "Todos3", type: :request do
  let!(:todo) { Todo.create!(name: "Buy milk", done: false) }

  describe "GET /todos" do
    it "returns a successful response" do
      get(todos_path)

      puts("sleep8s")
      sleep(8)
      puts("end")
      expect(response).to(have_http_status(:ok))
      expect(response.body).to(include("Buy milk"))
    end
  end

  describe "GET /todos/:id" do
    it "returns a successful response" do
      get(todo_path(todo))

      expect(response).to(have_http_status(:ok))
      expect(response.body).to(include("Buy milk"))
    end
  end

  describe "POST /todos" do
    it "creates a new todo and redirects" do
      expect do
        post(todos_path, params: { todo: { name: "Write tests", done: false } })
      end
        .to(change(Todo, :count).by(1))

      expect(response).to(have_http_status(:found))
      follow_redirect!
      expect(response.body).to(include("Todo was successfully created."))
    end
  end

  describe "PATCH /todos/:id" do
    it "updates the todo and redirects" do
      patch(todo_path(todo), params: { todo: { name: "Buy oat milk", done: true } })

      expect(response).to(have_http_status(:see_other))
      expect(todo.reload.name).to(eq("Buy oat milk"))
      expect(todo.done).to(be(true))
    end
  end

  describe "DELETE /todos/:id" do
    it "destroys the todo and redirects" do
      expect do
        delete(todo_path(todo))
      end
        .to(change(Todo, :count).by(-1))

      expect(response).to(have_http_status(:see_other))
    end
  end
end
