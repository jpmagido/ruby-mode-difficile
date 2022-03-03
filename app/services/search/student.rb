# frozen_string_literal: true

module Search
  class Student < Search::Base
    private

    def name(value)
      klass_scope.joins(:user).where('users.login ~* ?', value)
    end

    def answer_count_min(value)
      ::Student.where(
        id: klass_scope.joins(user: :answers)
                       .select { |student| student.user.answers.count >= value.to_i }
                       .map(&:id)
      )
    end

    def answer_count_max(value)
      ::Student.where(
        id: klass_scope.joins(user: :answers)
                       .select { |student| student.user.answers.count <= value.to_i }
                       .map(&:id)
      )
    end

    def has_coach(_)
      klass_scope.joins(:mentorships)
    end

    def language(value)
      klass_scope.joins(:user).where(users: { language: value })
    end
  end
end
