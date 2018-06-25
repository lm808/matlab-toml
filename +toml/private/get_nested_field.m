function value = get_nested_field(obj, indx)
  % check for existence
  switch class(obj)
    case 'cell'
      if numel(obj) < indx{1}
        error('toml:NoSuchIndex', 'This index does not exist.')
      end
    case 'struct'
      if ~isfield(obj, indx{1})
        error('toml:NoSuchIndex', 'This index does not exist.')
      end
  end

  % retrieve it
  value = get_item(obj, indx{1});
  % recurse if necessary
  if numel(indx) > 1
    value = get_nested_field(value, indx(2:end));
  end
end

function val = get_item(obj, indx2)
  switch class(obj)
    case 'cell'
      val = obj{indx2};
    case 'struct'
      val = obj.(indx2);
  end
end