#!/usr/bin/env ruby

require 'Qt'

require 'gettext'

class Calculator < Qt::Widget

	WIDTH = 300

	HEIGHT = 510

	include GetText

	bindtextdomain "Calculator"

        slots "print_one()"
        slots "print_two()"
        slots "print_three()"
        slots "print_four()"
        slots "print_five()"
        slots "print_six()"
        slots "print_seven()"
        slots "print_eight()"
        slots "print_nine()"
        slots "print_zero()"

	slots "print_dot()"
	slots "add()"
	slots "minus()"
	slots "multiple()"
	slots "divide()"
	slots "equal()"
	slots "percent()"
	slots "neg()"
	slots "ac()"

	def initialize

		super

		setWindowTitle _("Calculator")

		setWindowIcon(Qt::Icon.new("calculator.svgz"))

		init_ui

		setFixedSize WIDTH, HEIGHT

		center

		show

	end

	def center

		qdw = Qt::DesktopWidget.new
                x = (qdw.width - 600) / 2
                y = (qdw.height - 400) / 2
                move x, y

	end

	def init_ui

		grid = Qt::GridLayout.new self
		grid.setSpacing 0
		@display = Qt::LineEdit.new
		@display.setReadOnly true
		@display.setAlignment Qt::AlignRight
		to_zero
		@ac = Qt::PushButton.new "AC"
		@neg = Qt::PushButton.new "+/-"
		@percent = Qt::PushButton.new "%"
		@divide = Qt::PushButton.new "÷"
		@divide.setObjectName "divide"
		@multiple = Qt::PushButton.new "x"
		@multiple.setObjectName "multiple"
		@minus = Qt::PushButton.new "-"
		@minus.setObjectName "minus"
		@add = Qt::PushButton.new "+"
		@add.setObjectName "add"
		@equal = Qt::PushButton.new "="
		@equal.setObjectName "equal"
		@dot = Qt::PushButton.new "."
		@one = Qt::PushButton.new "1"
		@two = Qt::PushButton.new "2"
		@three = Qt::PushButton.new "3"
		@four = Qt::PushButton.new "4"
		@five = Qt::PushButton.new "5"
		@six = Qt::PushButton.new "6"
		@seven = Qt::PushButton.new "7"
		@eight = Qt::PushButton.new "8"
		@nine = Qt::PushButton.new "9"
		@zero = Qt::PushButton.new "0" 

		@tmp = ""
		@op = ""

		grid.addWidget @display, 0, 0, 1, 4
		grid.addWidget @ac, 1, 0, 1, 1
		grid.addWidget @neg, 1, 1, 1, 1
		grid.addWidget @percent, 1, 2, 1, 1
		grid.addWidget @divide, 1, 3, 1, 1
		grid.addWidget @seven, 2, 0, 1, 1
		grid.addWidget @eight, 2, 1, 1, 1
		grid.addWidget @nine, 2, 2, 1, 1
		grid.addWidget @multiple, 2, 3, 1, 1
		grid.addWidget @four, 3, 0, 1, 1
		grid.addWidget @five, 3, 1, 1, 1
		grid.addWidget @six, 3, 2, 1, 1
		grid.addWidget @minus, 3, 3, 1, 1
		grid.addWidget @one, 4, 0, 1, 1
		grid.addWidget @two, 4, 1, 1, 1
		grid.addWidget @three, 4, 2, 1, 1
		grid.addWidget @add, 4, 3, 1, 1
		grid.addWidget @zero, 5, 0, 1, 2
		grid.addWidget @dot, 5, 2, 1, 1
		grid.addWidget @equal, 5, 3, 1, 1 

		connect @dot, SIGNAL("clicked()"), SLOT("print_dot()")
		connect @add, SIGNAL("clicked()"), SLOT("add()")
		connect @minus, SIGNAL("clicked()"), SLOT("minus()")
		connect @multiple, SIGNAL("clicked()"), SLOT("multiple()")
		connect @divide, SIGNAL("clicked()"), SLOT("divide()")
		connect @equal, SIGNAL("clicked()"), SLOT("equal()")
		connect @neg, SIGNAL("clicked()"), SLOT("neg()")
		connect @percent, SIGNAL("clicked()"), SLOT("percent()")
		connect @ac, SIGNAL("clicked()"), SLOT("ac()")

		connect @one, SIGNAL("clicked()"), SLOT("print_one()")
                connect @two, SIGNAL("clicked()"), SLOT("print_two()")
                connect @three, SIGNAL("clicked()"), SLOT("print_three()")
                connect @four, SIGNAL("clicked()"), SLOT("print_four()")
                connect @five, SIGNAL("clicked()"), SLOT("print_five()")
                connect @six, SIGNAL("clicked()"), SLOT("print_six()")
                connect @seven, SIGNAL("clicked()"), SLOT("print_seven()")
                connect @eight, SIGNAL("clicked()"), SLOT("print_eight()")
                connect @nine, SIGNAL("clicked()"), SLOT("print_nine()")
                connect @zero, SIGNAL("clicked()"), SLOT("print_zero()")

	end

	def clear

		@display.clear

	end

	def to_zero

		@display.setText "0"

	end

	def release

		if @op != "" then

			case @op
			when "a"
				@add.setEnabled true
			when "m"
				@minus.setEnabled true
			when "mu"
				@multiple.setEnabled true
			when "d"
				@divide.setEnabled true
			end

		end

	end

	def add

		@add.setEnabled false

		if @op != "" then
			equal
		end

		@tmp = @display.text
		to_zero
		@op = "a"

	end

	def minus

		@minus.setEnabled false

		if @op != "" then
			equal
		end

		@tmp = @display.text
		to_zero
		@op = "m"

	end

	def multiple

		@multiple.setEnabled false

		if @op != "" then
			equal
		end

		@tmp = @display.text
		to_zero
		@op = "mu"

	end

	def divide

		@divide.setEnabled false

		if @op != "" then
			equal
		end

		@tmp = @display.text
		to_zero
		@op = "d"

	end

	def equal

		text = @display.text

		if @op != "" then

			case @op

			when "a" 

				result = @tmp.to_f + text.to_f

				if @tmp.include?(".") == false && text.include?(".") == false then
					array = result.to_s.split(".")
					result = array[0]
				end

				@display.setText(result.to_s)

			when "m"

				result = @tmp.to_f - text.to_f

                                if @tmp.include?(".") == false && text.include?(".") == false then
                                        array = result.to_s.split(".")
                                        result = array[0]
                                end

				@display.setText(result.to_s)

			when "mu"
				
				result = @tmp.to_f * text.to_f

                                if @tmp.include?(".") == false && text.include?(".") == false then
                                        array = result.to_s.split(".")
                                        result = array[0]
                                end

                                @display.setText(result.to_s)

			when "d"

				if text != "" then

                                	result = @tmp.to_f / text.to_f

	                                array = result.to_s.split(".")

					test = array[1]
                                
					num = array[1].size - 1

					if test[num] == "0" then
						result = array[0]
                                	end
                        
                                	@display.setText(result.to_s)

				end

			else

			end

		end

		@tmp = ""
		@op = ""

	end

	def percent

		text = @display.text
		if text != "" then

			result = text.to_f / 100

			array = result.to_s.split(".")

			test = array[1]

			num = array[1].size - 1

			if test[num] == "0" then
				result = array[0]
			end

			@display.setText(result.to_s)

		end

	end

	def neg

		text = @display.text

		if text[0] != "-" then

			result = "-" + text

		else

			array = text.split("-")
			result = array[1]

		end

		@display.setText(result)

	end

	def ac

		if @op != "" then
			to_zero
		else
			to_zero
			@tmp = ""
			@op = ""
		end

	end

	def print_dot

		text = @display.text

		unless @display.text.include?(@dot.text) then
			result = text + @dot.text
		end

		@display.setText(result)

	end

	def print_one

		if @display.text == "0" then
			clear
		end

		text = @display.text
		result = text + @one.text
		@display.setText(result)

		release

	end

        def print_two

                if @display.text == "0" then
                        clear
                end

                text = @display.text
                result = text + @two.text
                @display.setText(result)

		release

        end

        def print_three

                if @display.text == "0" then
                        clear
                end

                text = @display.text
                result = text + @three.text
                @display.setText(result)

		release

        end

        def print_four

                if @display.text == "0" then
                        clear
                end

                text = @display.text
                result = text + @four.text
                @display.setText(result)

		release

        end

        def print_five

                if @display.text == "0" then
                        clear
                end

                text = @display.text
                result = text + @five.text
                @display.setText(result)

		release

        end

        def print_six

                if @display.text == "0" then
                        clear
                end

                text = @display.text
                result = text + @six.text
                @display.setText(result)

		release

        end

        def print_seven

                if @display.text == "0" then
                        clear
                end

                text = @display.text
                result = text + @seven.text
                @display.setText(result)

		release

        end

        def print_eight

                if @display.text == "0" then
                        clear
                end

                text = @display.text
                result = text + @eight.text
                @display.setText(result)

		release

        end

        def print_nine

                if @display.text == "0" then
                        clear
                end

                text = @display.text
                result = text + @nine.text
                @display.setText(result)

		release

        end

        def print_zero

                text = @display.text
                result = text + @zero.text
                @display.setText(result)

		release

        end

end

app = Qt::Application.new ARGV

open("style.qss",'r') {|f| app.setStyleSheet(f.read)}

calculator = Calculator.new

app.exec
