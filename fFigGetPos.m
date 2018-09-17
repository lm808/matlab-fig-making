function p = fFigGetPos(handle)

if nargin == 0
    handle = gcf;
end

p = get(figure(handle),'outerposition');

clipboard('copy',['set(gcf,''OuterPosition'',[',fNum2str(p,','),'])'])

end

function s = fNum2str(n,delimiter)

s = strjoin(arrayfun(@(x) num2str(x),n,'UniformOutput',false),delimiter);
s = sprintf(s);

end
