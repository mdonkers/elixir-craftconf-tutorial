defmodule OTP.EchoTest do
  use ExUnit.Case, async: true
  alias OTP.Echo

  test "echo" do
    {:ok, pid} = Echo.start_link()
    Echo.send(pid, :hello)
    assert_receive :hello
    Echo.send(pid, :hi)
    assert_receive :hi

    Kernel.send(pid, :another_message)
    Process.sleep(10)
    assert Process.alive?(pid)
  end

  test "times out after 50 ms" do
    {:ok, pid} = Echo.start_link()

    Process.sleep(51)
    refute Process.alive?(pid)
  end

end
