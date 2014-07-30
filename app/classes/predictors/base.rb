class Predictors::Base

  def predict(type, strategy, options={})
    data_loader = Predictors::DataLoader.new(type)
    lists       = data_loader.fetch_data
    predictor   = "Predictors::Strategies::#{strategy}".constantize.new(lists)
    batch_size  = lists.first.size
    predictor.run(batch_size, batch_size * 3)
  end

  # Get a hash that having the frequency of the numbers appear
  # in the lottery
  #
  # @params data [Array<Array<String>>], like [["1", "5"],["5","6"]]
  def get_count_hash(data)
    cache = Hash.new(0)

    data.each do |numbers|
      numbers.each do |num|
        cache[num] += 1
      end
    end

    cache
  end

  # select top n number from an array of x
  # @params data [Array] ['1', '3']
  # @params n [Fixnum]
  def random_select_top_n(data, n)
    return data if n > data.size
    ret = []
    range = create_prod_ary data.size
    size  = range.last
    n.times.each do |i|
      num = rand(size)
      idx = num_to_idx(num, range)
      unique_insert(ret, data, idx)
    end
    ret
  end

  private

  # It should returnt the max number of that range in the
  # array.
  # @params size [Fixnum] size of the array
  # @returns [Array] if size == 2, then it should return [1,3]
  def create_prod_ary(size)
    ret = []
    sum = 0
    (1..size).each do |i|
      sum += i
      ret << sum
    end
    ret
  end

  # Convert range to the idx from the origian data
  def num_to_idx(num, range)
    return 0 if num == 0
    range.each_with_index do |r, idx|
      return idx if idx > 0 && range[idx - 1] < num && num <= r
      return idx if idx == 0 && r >= num
    end
  end

  # Since the recommendated array should be unqiue
  # and the random generated number cannot be unique all the time.
  # if it contais the num then it use the next one
  def unique_insert(array, data, idx, max_tries=10)
    idx = idx % data.size
    if array.include?(data[idx])
      idx = max_tries == 0 ? idx + 1 : idx+rand(data.size)
      unique_insert(array, data, idx, max_tries-=1)
    else
      array << data[idx]
    end
  end
end