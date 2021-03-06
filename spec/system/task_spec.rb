require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    Task.create!(title: 'test_task_01', content: 'test_content_01')
    Task.create!(title: 'test_task_02', content: 'test_content_01')
  end
  #3種類のタスク管理機能のシステムのテストをする
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[title]", with: "test_task_01"
        fill_in "task[content]", with: "test_task_01"
        click_on 'Create Task'
        expect(page).to have_content 'test_task_01'
      end
    end
  end

  describe '一覧表示機能' do
    #一覧表示のテスト
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        #上記になれば成功
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
        #移行したタスク一覧ページにtaskの内容（content）があれば成功
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, content: 'task')
        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end
end