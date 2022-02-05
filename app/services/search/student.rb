# frozen_string_literal: true

module Search
  class Student
    attr_accessor :klass_scope
    attr_reader :params

    def initialize(klass_scope, params)
      @klass_scope = klass_scope
      @params = params
    end

    def search
      sanitized_params.each { |key, value| self.klass_scope = send key, value }

      klass_scope
    end

    private

    def name(value)
      klass_scope.joins(:user).where('users.login ~* ?', value)
    end

    def challenge_count_min(value)
      ::Student.where(id: klass_scope.joins(user: :answers)
                                   .select { |student| student.user.answers.count >= value.to_i }
                                   .map(&:id))
    end

    def challenge_count_max(value)
      ::Student.where(id: klass_scope.joins(user: :answers)
                                   .select { |student| student.user.answers.count <= value.to_i }
                                   .map(&:id))
    end

    def has_coach(_)
      klass_scope.joins(:mentorships)
    end

    def language(value)
      klass_scope.joins(:user).where(users: { language: value })
    end

    def sanitized_params
      params.to_h.select { |_, value| value.present? }
    end
  end
end
