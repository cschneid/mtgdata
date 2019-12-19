# Create one of these with a block, and push individual items of work at it.
# When the batch fills up, or when you run finalize!, an array of work items
# will be passed to your block for execution all at once.
#
# Used initially to batch up data point inserts into Influx
class BatchedWork
  attr_reader :batch_size
  attr_reader :on_run

  def initialize(batch_size: 1000, &on_run)
    @batch_size = batch_size
    @on_run = on_run
    reset_items_waiting
  end

  def add_to_batch(item)
    items_waiting << item
    execute_batch! if items_waiting.length >= batch_size
  end

  # Flush any remaining items out in an execute_batch call
  def finalize!
    execute_batch! if items_waiting.any?
  end

  private
  attr_accessor :items_waiting

  def reset_items_waiting
    @items_waiting = []
  end

  def execute_batch!
    on_run.call(items_waiting)
    reset_items_waiting
  end
end
